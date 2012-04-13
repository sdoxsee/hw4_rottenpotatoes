require 'spec_helper'

describe MoviesController do
  describe 'finding similar movies' do
    before :each do
      Movie.stub!(:find).and_return(@mock_movie = mock('Movie'))
      @mock_movie.stub!(:id).and_return(1)
      @mock_movie.stub!(:title).and_return('Back To The Future')      
      @mock_movie.stub!(:director).and_return('Steven Spielberg')
    end
    it 'happy path' do
      @mock_movie.stub!(:find_movies_with_same_director).and_return([mock('Movie')])
      get :similar_movies, :id => @mock_movie.id
      flash.now[:notice].should be_nil
    end
    it 'nothing found' do
      @mock_movie.stub!(:find_movies_with_same_director).and_return([])
      get :similar_movies, :id => @mock_movie.id
      flash.now[:notice].should == 'No similar movies found'
    end
    it 'director blank' do
      @mock_movie.stub!(:director).and_return(nil)
      get :similar_movies, :id => @mock_movie.id
      flash.now[:notice].should_not be_nil
    end
    it 'should go to the home page sorted by title' do
      get :index, :sort => 'title'
    end
    it 'should go to the home page sorted by release_date' do
      get :index, :sort => 'release_date'
    end
    it 'should show' do
      get :show, :id => @mock_movie.id
    end
    it 'should create' do
      post :create, :movie => {:title => 'Foo'}
    end
    it 'should update' do
      @mock_movie.stub!(:update_attributes!)
      put :update, :id => @mock_movie.id
    end
    it 'should destroy' do
      @mock_movie.stub!(:destroy)
      delete :destroy, :id => @mock_movie.id
    end
    it 'should edit' do
      get :edit, :id => @mock_movie.id
    end
  end
end