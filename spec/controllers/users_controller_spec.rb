require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe "#index" do
    let!(:all_users) { User.all }
    before { get :index }

    it "assigns @users" do
      expect(assigns(:users)).to eq(all_users)
    end

    it "renders the :index view" do
      expect(response).to render_template(:index)
    end
  end
  describe "#new" do
    before { get :new }

    it "assigns @user" do
      expect(assigns(:user)).to be_instance_of(User)
    end

    it "renders the :new view" do
      expect(response).to render_template(:new)
    end
  end
end
