class Schedule < ApplicationRecord
  belongs_to :user
  validates :title, presence: true
  validates :starting_date, presence: true
  validates :starting_hour, presence: true

  validate :ending_date_after_starting_date

  private

  def ending_date_after_starting_date
    return if ending_date.blank? || starting_date.blank?

    if ending_date < starting_date
      errors.add(:ending_date, "¡Vaya viaje en el tiempo! Tu fecha final es anterior al inicio; ajústala por favor.")
    end
  end
end
