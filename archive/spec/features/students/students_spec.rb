require 'spec_helper'

describe 'Students', type: :feature do

  before(:all) do
    set_resource 'student'
  end

  before { as :admin }

  let(:enrollment_status_admitted) { create(:enrollment_status_admitted) }
  let(:student) { create(:student, name: 'John', surname: 'Doe', enrollment_status_code: enrollment_status_admitted.code) }


  context 'existing' do
    before do
      student
      visit gaku.students_path
    end


    it 'deletes', js: true do
      visit gaku.edit_student_path(student)
      student_count = Gaku::Student.count

      expect do
        click modal_delete_link
        within(modal) { click_on 'Delete' }
        accept_alert
        flash_destroyed?
      end.to change(Gaku::Student, :count).by -1

      within(count_div) { page.should_not have_content 'Students list(#{student_count - 1})' }
      current_path.should eq gaku.students_path
    end

  end


end
