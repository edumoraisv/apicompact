# frozen_string_literal: true

module Inputs
  class Alternative < Types::BaseInputObject
    argument :correct, Boolean, required: false
    argument :text, String, required: false
  end

  class SaveQuestionInput < Types::BaseInputObject
    argument :id, ID, required: false
    argument :instruction, String, required: true
    argument :support, String, required: true
    argument :body, String, required: true
    argument :alternatives, [Alternative], required: true
    argument :explanation, String, required: true
    argument :references, String, required: true
    argument :check_type, Types::Questions::CheckType, required: true
    argument :difficulty, Types::Questions::Difficulty, required: true
    argument :bloom_taxonomy, Types::Questions::BloomTaxonomy, required: true
    argument :authorship_year, String, required: true
    argument :source, String, required: true

    argument :subject_id, ID, required: true
    argument :reviewer_id, ID, required: true
  end
end
