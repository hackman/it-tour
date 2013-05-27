require 'spec_helper'

describe Admin::ConferencesController do
 stub_rendering

 let(:conference) { double :conference }

 describe "GET index" do
    it "assigns all conferences" do
      Conference.stub all: [conference]
      get :index
      expect(assigns[:conferences]).to eq [conference]
    end
  end

  describe "GET new" do
    it "assigns new conference" do
      Conference.stub new: conference
      get :new
      expect(assigns[:conference]).to eq conference
    end
  end

  describe "GET create" do
    before do
      Conference.stub(:create).with('name' => 'VarnaConf').and_return conference
    end

    it "creates a new conference" do
      Conference.should_receive(:create).with('name' => 'VarnaConf').and_return conference
      get :create, conference: {name: 'VarnaConf'}
    end

    it "assigns the new conference" do
      get :create, conference: {name: 'VarnaConf'}
      expect(assigns[:conference]).to eq conference
    end

    it "responds with the new conference" do
      controller.should_receive(:respond_with).with(conference, location: admin_conferences_path)
      get :create, conference: {name: 'VarnaConf'}
    end
  end

  describe "GET show" do
    it "assigns the conference" do
      Conference.stub(:find).with('1').and_return conference
      get :show, id: '1'
      expect(assigns[:conference]).to eq conference
    end
  end

  describe "GET edit" do
    it "assigns the conference" do
      Conference.stub(:find).with('1').and_return conference
      get :edit, id: '1'
      expect(assigns[:conference]).to eq conference
    end
  end

  describe "GET update" do
    before do
      Conference.stub(:update).with('1', 'name' => 'VarnaConf').and_return conference
    end

    it "updates the conference" do
      Conference.should_receive(:update).with('1', 'name' => 'VarnaConf').and_return conference
      put :update, id: '1', conference: {name: 'VarnaConf'}
    end

    it "assigns the conference" do
      put :update, id: '1', conference: {name: 'VarnaConf'}
      expect(assigns[:conference]).to eq conference
    end

    it "responds with the conference" do
      controller.should_receive(:respond_with).with(conference, location: admin_conferences_path)
      put :update, id: '1', conference: {name: 'VarnaConf'}
    end
  end

  describe "DELETE destroy" do
    before do
      Conference.stub(:destroy).with('1')
    end

    it "removes the conference" do
      Conference.should_receive(:destroy).with('1')
      delete :destroy, id: '1'
    end

    it "redirects to conferences list" do
      delete :destroy, id: '1'
      expect(controller).to redirect_to admin_conferences_path
    end
  end
end