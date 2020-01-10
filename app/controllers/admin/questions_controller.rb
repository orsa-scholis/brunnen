# frozen_string_literal: true

module Admin
  class QuestionsController < Admin::ApplicationController
    before_action :load_answer_possibility_groups, except: %i[show destroy]

    # Overwrite any of the RESTful controller actions to implement custom behavior
    # For example, you may want to send an email after a foo is updated.
    #
    # def update
    #   foo = Foo.find(params[:id])
    #   foo.update(params[:foo])
    #   send_foo_updated_email
    # end

    # Override this method to specify custom lookup behavior.
    # This will be used to set the resource for the `show`, `edit`, and `update`
    # actions.
    #
    # def find_resource(param)
    #   Foo.find_by!(slug: param)
    # end

    # Override this if you have certain roles that require a subset
    # this will be used to set the records shown on the `index` action.
    #
    # def scoped_resource
    #  if current_user.super_admin?
    #    resource_class
    #  else
    #    resource_class.with_less_stuff
    #  end
    # end

    # See https://administrate-prototype.herokuapp.com/customizing_controller_actions
    # for more information

    private

    def load_answer_possibility_groups
      @answer_possibility_groups = AnswerPossibilityGroup.all.map do |answer_possibility_group|
        { description: answer_possibility_group.description, ids: answer_possibility_group.answer_possibility_ids }
      end
    end
  end
end
