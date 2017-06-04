class Setting < ApplicationRecord
    validates :name, presence: true, uniqueness: { case_sensitive: true }
    validates :value, presence: true

    def self.get(name, default=false)
        setting = self.where(name: name).first
        if setting
            setting.value
        else
            default
        end
    end

    def self.set(name, value)
        setting = self.where(name: name).first
        if setting
            setting.value = value
            setting.save
        else
            setting = self.new()
            setting.name = name
            setting.value = value
            setting.save
        end 
    end
end
