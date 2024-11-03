require 'swagger_helper'

describe 'API::V1::PaymentIntentsController', swagger_doc: SWG_PAYMENT do
  path '/api/v1/payment_intents' do
    get 'Get payment intents' do
      tags 'Payment Intents'
      operationId 'paymentIntentsIndex'
      produces 'application/json'

      extend Rswag::Parameters::Pagination

      before { create(:subscription) }

      response(200, 'Successful response') do
        schema_path = 'v1/payment_intents/index'

        schema Helpers::RequestHelpers.load_schema(schema_path)

        it_behaves_like 'responds with schema', schema_path
      end
    end

    post 'Creates a payment intent' do
      tags 'Payment Intents'
      consumes 'multipart/form-data'
      produces 'application/json'

      parameter in: :body, schema: {
        type: :object,
        properties: {
          subscription_id: { type: :integer, description: 'Subscription ID' },
          amount: { type: :float, description: 'Amount' }
        },
        required: %i[subscription_id amount]
      }

      parameter name: :subscription_id, in: :formData, type: :integer
      parameter name: :amount, in: :formData, type: :float

      let(:subscription_id) { subscription.id }
      let(:amount) { 1000 }

      let(:subscription) { create(:subscription) }

      response(201, 'Payment intent created') do
        schema_path = 'v1/payment_intents/create'

        schema Helpers::RequestHelpers.load_schema(schema_path)

        it_behaves_like 'responds with schema', schema_path
      end

      response(422, 'Not processable content') do
        let(:fail_response) { double(success?: false, error: 'Unable to create a mayment intent') }

        before do
          allow(Billing::PaymentIntent).to receive(:call).and_return(fail_response)
        end

        run_test!
      end

      response(404, 'Not Found') do
        let(:subscription_id) { 'invalid' }

        run_test!
      end
    end
  end

  path '/api/v1/payment_intents/{subscription_id}' do
    get 'Retrieves a subscription' do
      tags 'Payment Intents'
      produces 'application/json'
      parameter name: :subscription_id, in: :path, type: :integer, description: 'Subscription ID'

      response(200, 'Successful response') do
        let(:subscription_id) { create(:subscription).id }

        schema_path = 'v1/payment_intents/show'

        schema Helpers::RequestHelpers.load_schema(schema_path)

        it_behaves_like 'responds with schema', schema_path
      end

      response(404, 'Not Found') do
        let(:subscription_id) { 'invalid' }
        run_test!
      end
    end
  end
end
