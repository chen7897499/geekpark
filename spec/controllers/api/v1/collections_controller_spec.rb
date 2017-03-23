require 'rails_helper'

describe API::V1::CollectionsController, type: :controller do
  let(:collections) { create_list(:collection, 3) }

  it_behaves_like(:indicable, Collection, as: :editor)
  it_behaves_like(:destructible, :collection, as: :editor)
  it_behaves_like(:creatable, Collection, as: :editor) do
    let(:query) {
      Hash[
        title: FFaker::LoremCN.words(2).join,
        description: FFaker::LoremCN.words(2).join
      ]
    }
  end

  describe 'show' do
    it 'show collection correctly' do
      c = collections.first
      get :show, params: { id: c.id }
      expect(response).to be_success
      expect(result).to be_a(Hash)
      expect(result).not_to include('meta')
    end

    it 'show collection correctly for managers' do
      c = collections.first
      get :show, params: { id: c.id, **as(:admin) }
      expect(result['collection']).to include('meta')
    end
  end

  it_behaves_like(:updatable, :collection, as: :admin) do
    let(:query) {
      Hash[
        title: '1',
        description: '2',
        banner: '3',
        banner_mobile: '4',
        meta: { 'paginate_per' => '100' }
      ]
    }
  end

  describe 'add_members' do
    it 'add members correctly' do
      n = 3
      c = create(:collection, :with_posts)
      posts = create_list(:post, n)

      expect {
        post :add_members,
             params: {
               collection_id: c.id,
               post_ids: posts.pluck(:id),
               **as(:editor),
               format: :json
             }
      }.to change { c.posts.count }.by(n)
      expect(c.posts.pluck(:id)).to include(*posts.pluck(:id))
    end
  end

  describe 'reset_members' do
    it 'reset members correctly' do
      n = 4
      c = create(:collection, :with_posts)
      posts = create_list(:post, n)

      expect {
        post :reset_members,
             params: {
               collection_id: c.id,
               post_ids: posts.pluck(:id),
               **as(:editor),
               format: :json
             }
      }.to change { c.posts.count }.to(n)
      expect(c.posts.pluck(:id)).to match_array(posts.pluck(:id))
    end
  end
end
