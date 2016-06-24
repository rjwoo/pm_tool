require 'rails_helper'

RSpec.describe Project, type: :model do
  describe "validations" do
    it "requires a project title" do
      p = Project.new
      p.valid?
      expect(p.errors).to have_key(:title)
    end

    it "requires a unique project title" do
      Project.create
      p = Project.new
      p.valid?
      expect(p.errors).to have_key(:title)
    end

    it "requires a due_date greater than today's date" do
      p = Project.new
      p.valid?
      expect(p.errors).to have_key(:due_date)
    end
  end
end
