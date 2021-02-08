# frozen_string_literal: true

module Inputs
  class Alternative < Types::BaseInputObject
    argument :correct, Boolean, required: false
    argument :text, String, required: false
  end

  class SaveDraftQuestionInput < Types::BaseInputObject
    argument :id, ID, required: false
    argument :instruction, String, required: false
    argument :support, String, required: false
    argument :body, String, required: false
    argument :alternatives, [Alternative], required: false
    argument :explanation, String, required: false
    argument :references, String, required: false
    argument :check_type, Types::Questions::CheckType, required: false
    argument :difficulty, Types::Questions::Difficulty, required: false
    argument :bloom_taxonomy, Types::Questions::BloomTaxonomy, required: false
    argument :authorship_year, String, required: false
    argument :source, String, required: false

    argument :subject_id, ID, required: false
    argument :reviewer_id, ID, required: false
  end
end
