# frozen_string_literal: true

RSpec.shared_examples_for 'preventing display of inactive or already submitted surveys' do
  context 'when survey was already submitted' do
    let(:submission_tracking) { instance_double(SubmissionTracking, submitted?: true) }

    before { allow(SubmissionTracking).to receive(:load).and_return(submission_tracking) }

    it 'returns a 404 Not Found' do
      expect { request }.to raise_error ActiveRecord::RecordNotFound
    end
  end

  context 'when survey is inactive' do
    before { survey.update active_from: 4.days.ago, active_to: 2.days.ago }

    it 'returns a 404 Not Found' do
      expect { request }.to raise_error ActiveRecord::RecordNotFound
    end
  end

  context 'when an administrator is signed in' do
    let(:administrator) { create :administrator }

    before { sign_in administrator }

    it 'is successful' do
      request
      expect(response).to be_successful
    end

    context 'when survey is inactive' do
      before do
        survey.update active_from: 4.days.ago, active_to: 2.days.ago
        request
      end

      it 'returns successful response' do
        expect(response).to be_successful
      end
    end

    context 'when survey was already submitted' do
      let(:submission_tracking) { instance_double(SubmissionTracking, submitted?: true, decode: '') }

      before do
        allow(SubmissionTracking).to receive(:new).and_return(submission_tracking)
        request
      end

      it 'returns successful response' do
        expect(response).to be_successful
      end
    end
  end
end

RSpec.shared_examples_for 'preventing submission of inactive or already submitted surveys' do
  subject { post_request }

  context 'when survey was already submitted' do
    let(:submission_tracking) { instance_double(SubmissionTracking, submitted?: true) }

    before { allow(SubmissionTracking).to receive(:load).and_return(submission_tracking) }

    it 'returns a 404 Not Found' do
      expect { post_request }.to raise_error ActiveRecord::RecordNotFound
    end
  end

  context 'when survey is inactive' do
    before { survey.update active_from: 4.days.ago, active_to: 2.days.ago }

    it 'returns a 404 Not Found' do
      expect { post_request }.to raise_error ActiveRecord::RecordNotFound
    end
  end

  context 'when an administrator is signed in' do
    let(:administrator) { create :administrator }

    before { sign_in administrator }

    it 'is successful' do
      post_request
      expect(response).to redirect_to(root_path)
    end

    context 'when survey is inactive' do
      before do
        survey.update active_from: 4.days.ago, active_to: 2.days.ago
        post_request
      end

      it 'returns successful response' do
        expect(response).to redirect_to(root_path)
      end
    end

    context 'when survey was already submitted' do
      let(:submission_tracking) do
        instance_double(SubmissionTracking, :submitted? => true, :decode => '', :<< => true, save: true)
      end

      before do
        allow(SubmissionTracking).to receive(:new).and_return(submission_tracking)
        post_request
      end

      it 'returns successful response' do
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
