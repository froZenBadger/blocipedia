class Wiki < ActiveRecord::Base
  belongs_to :user
  has_many :collaborators
  # has_many :users, through: :collaborators

  default_scope { order('created_at DESC') }
  scope :visible_to, -> (user) { user.premium ? all : joins(:wiki).where('wiki.private' => false) }

  validates :title, length: {minimum: 5 }, presence: true
  validates :body, length: {minimum: 20 }, presence: true
  validates :user, presence: true

  validates :private, inclusion: {in: [true, false]}

  # validates :private, inclusion: {in: [true, false]}

  after_initialize :set_wiki_default, :if => :new_record?

  def set_wiki_default
    self.private ||= false
  end

  class << self
    def markdown(text)
      extentsions = {autolink: true, strikethrough: true, tables: true, fenced_code_blocks: true,
         underline: true, footnotes: true, highlight: true, quote: true, hard_wrap: true,
         safe_links_only: true, escape_html: true }
      Redcarpet::Markdown.new(Redcarpet::Render::HTML, extentsions).render(text).html_safe
    end
  end
end
