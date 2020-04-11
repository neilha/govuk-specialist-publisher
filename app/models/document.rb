class Document < ApplicationRecord
    has_many :attachments
    validates :title, presence: true
    validates :summary, presence: true
    validates :body, presence: true    
    validates :publication_state, presence: true

    def draft?
        # publication_state == "draft" || publication_state.nil?
        publication_state =~ /draft/ || publication_state.nil?        
    end

    def first_draft?
        # draft? && state_history_one_or_shorter?
        draft?
    end
end
