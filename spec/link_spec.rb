require 'link'

describe Link do
  context '#all' do
    it 'returns all the links' do
      links = Link.all
      urls = links.map(&:url)
      expect(urls).to include("http://www.makersacademy.com")
      expect(urls).to include("http://www.facebook.com")
      expect(urls).to include("http://www.google.com")
    end
  end
  context '.add_new_link' do
    it 'add new link to the end of bookmark list' do
      Link.add_new_link('http://www.testlink.com')
      links = Link.all
      urls = links.map(&:url)
      expect(urls).to include('http://www.testlink.com')
    end
  end
  context '.delete(id)' do
    it 'deletes the row that the id corresponds to' do
      Link.delete(1)
      links = Link.all
      urls = links.map(&:url)
      expect(urls).not_to include("http://www.makersacademy.com")
    end
  end
  context '.update(id, url)' do
    it 'updates the URL with a new one entered in' do
      Link.update(1, "http://www.reddit.com")
      links = Link.all
      urls = links.map(&:url)
      expect(urls).not_to include("http://www.makersacademy.com")
      expect(urls).to include("http://www.reddit.com")
    end
  end


end
