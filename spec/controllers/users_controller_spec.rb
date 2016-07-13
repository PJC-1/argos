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
  describe "#create" do
    context "on success" do
      let!(:users_count) { User.count }

      before do
        user_hash = {
          first_name: FFaker::Name.first_name,
          last_name: FFaker::Name.last_name ,
          password: "123456",
          email: FFaker::Internet.email
        }
        post :create, user: user_hash
      end

      it "adds the new user to the database" do
        expect(User.count).to eq(users_count + 1)
      end

      it "redirects to 'user_path'" do
        expect(response.status).to be(302)
        expect(response.location).to match(/\/users\/\d+/)
      end
    end
    context "failed validations" do
      before do
        post :create, user: {
          first_name: nil,
          last_name: nil,
          password: nil,
          email: nil
        }
      end
      it "adds a flash error message" do
        expect(flash[:error]).to be_present
      end
      it "redirects to 'new_user_path'" do
        expect(response.status).to be(302)
        expect(response).to redirect_to(new_user_path)
      end
    end
  end
  describe "#show" do
    context "on success" do
      let(:user) { FactoryGirl.create(:user) }
      let(:current_user) { user }
      before do
        get :show, id: user.id
      end

      it "assigns @user" do
        expect(assigns(:user)).to eq(user)
      end
      it "compares current_user to not equal nil" do
        expect(current_user).to be_present
      end
    end
  end
end
