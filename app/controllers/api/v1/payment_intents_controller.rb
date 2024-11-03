module Api
  module V1
    class PaymentIntentsController < Api::BaseController
      def index
        subscriptions = Subscription.order(created_at: :desc).page(params[:page]).per(params[:per_page])

        render json: subscriptions, each_serializer: ::V1::Subscriptions::SubscriptionSerializer
      end

      def show
        subscription = Subscription.find(params[:id])

        render json: subscription, serializer: ::V1::Subscriptions::SubscriptionSerializer
      end

      def create
        subscription = Subscription.find(create_params[:subscription_id])

        # validator = ::V1::SubscriptionValidator.new(create_params)
        # return response_invalid(validator) if validator.invalid?

        result = Billing::PaymentIntent.call(subscription:, amount: create_params[:amount].to_f)

        if result.success?
          render json: result.subscription, serializer: ::V1::Subscriptions::SubscriptionSerializer, status: :created
        else
          response_invalid([result.error])
        end
      end

      private

      def create_params
        params.permit(:subscription_id, :amount)
      end
    end
  end
end
