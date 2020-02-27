# frozen_string_literal: true

require 'rails_helper'

def squish_html(html)
  html.squish.gsub('> ', '>')
end

RSpec.describe NavbarHelper, type: :helper do
  describe '#navbar_item' do
    subject(:navbar_item) { helper.navbar_item(title, path, options) }

    let(:title) { 'My title' }
    let(:path) { '/my/path' }
    let(:options) { {} }

    context 'when user is on same page as link refers to' do
      before { allow(helper).to receive(:current_page?).and_return true }

      it 'returns an active navbar item' do
        expect(navbar_item).to eq squish_html(
          <<~HTML
            <li class="nav-item active">
              <a class="nav-link" href="/my/path">My title</a>
            </li>
          HTML
        )
      end
    end

    context 'when user is not on same page as link refers to' do
      before { allow(helper).to receive(:current_page?).and_return false }

      it 'returns an active navbar item' do
        expect(navbar_item).to eq squish_html(
          <<~HTML
            <li class="nav-item">
              <a class="nav-link" href="/my/path">My title</a>
            </li>
          HTML
        )
      end
    end
  end
end
