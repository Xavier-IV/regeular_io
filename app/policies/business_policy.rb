# frozen_string_literal: true

class BusinessPolicy < ApplicationPolicy
  class Scope < Scope
    def create?
      user.owner? || record.user == user
    end

    def show?
      user.owner? || record.user == user
    end

    def update?
      user.owner? || record.user == user
    end
  end
end
