require 'spec_helper'

describe ActivitiesController do
  describe "authentication" do
    describe "before login" do
      it "should redirect to login on listing activites" do
        get :index
        expect(response).to redirect_to new_user_session_path
      end

      it "should redirect to login on listing activites" do
        get :new
        expect(response).to redirect_to new_user_session_path
      end

      it "should redirect to login on listing activites" do
        post :create
        expect(response).to redirect_to new_user_session_path
      end

      it "should redirect to login on listing activites" do
        get(:show, id: 1)
        expect(response).to redirect_to new_user_session_path
      end

      it "should redirect to login on editing an activity" do
        get(:edit, id: 1)
        expect(response).to redirect_to new_user_session_path
      end

      it "should redirect to login on modifying an activity" do
        put(:update, id: 1)
        expect(response).to redirect_to new_user_session_path
      end

      it "should redirect to login on deleting an activity" do
        delete(:destroy, id: 1)
      end

    end  
  end
end