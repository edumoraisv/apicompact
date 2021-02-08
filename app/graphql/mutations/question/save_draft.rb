# frozen_string_literal: true

module Mutations
  module Question
    class SaveDraft < BaseMutation
      type Types::Questions::Response

      argument :question, Inputs::SaveDraftQuestionInput, required: true

      def resolve(question:)
        input = question.to_h
        reviewer_id = input.delete(:reviewer_id)
        user = context[:current_user]

        question = input[:id] ? ::Question.find_by(id: input[:id]) : ::Question.new(user_id: user.id)
        policy = QuestionPolicy.new(user, question)

        question.status = 'draft'

        return {} unless input[:id] ? policy.update? : policy.create?

        if question.update(input)
          question.review_requests
                  .where.not(user_id: reviewer_id)
                  .destroy_all

          if reviewer_id
            ::ReviewRequest.find_or_create_by(
              question_id: question.id,
              user_id: reviewer_id
            )
          end

          return { payload: question }
        end

        { errors: ::ResponseError.from_active_record_model(question) }
      end
    end
  end
end
