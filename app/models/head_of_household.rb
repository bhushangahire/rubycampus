#--                                                  /THIS FILE IS A PART OF RUBYCAMPUS/
# +------------------------------------------------------------------------------------+
# | RubyCampus - Relationship Management & Alumni Development Software                 |
# +------------------------------------------------------------------------------------+
# | Copyright (C) 2008 Kevin Aleman, RubyCampus LLC - https://rubycampus.org           |
# +------------------------------------------------------------------------------------+
# |                                                                                    |
# | This program is free software; you can redistribute it and/or modify it under the  |
# | terms of the GNU Affero General Public License version 3 as published by the Free  |
# | Software Foundation with the addition of the following permission added to Section |
# | 15 as permitted in Section 7(a): FOR ANY PART OF THE COVERED WORK IN WHICH THE     |
# | COPYRIGHT IS OWNED BY RUBYCAMPUS LLC, RUBYCAMPUS LLC DISCLAIMS THE WARRANTY OF NON |
# | INFRINGEMENT OF THIRD PARTY RIGHTS.                                                |
# |                                                                                    |
# | This program is distributed in the hope that it will be useful, but WITHOUT ANY    |
# | WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A    |
# | PARTICULAR PURPOSE.  See the GNU Affero General Public License for more details.   |
# |                                                                                    |
# | You should have received a copy of the GNU Affero General Public License along     |
# | with this program; if not, see http://www.gnu.org/licenses or write to the Free    |
# | Software Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301  |
# | USA.                                                                               |
# |                                                                                    |
# | You can contact RubyCampus, LLC. at email address project@rubycampus.org.          |
# |                                                                                    |
# | The interactive user interfaces in modified source and object code versions of     |
# | this program must display Appropriate Legal Notices, as required under Section 5   |
# | of the GNU Affero General Public License version 3.                                |
# |                                                                                    |
# | In accordance with Section 7(b) of the GNU Affero General Public License version   |
# | 3, these Appropriate Legal Notices must retain the display of the "Powered by      |
# | RubyCampus" logo. If the display of the logo is not reasonably feasible for        |
# | technical reasons, the Appropriate Legal Notices must display the words "Powered   |
# | by RubyCampus".                                                                    |
# +------------------------------------------------------------------------------------+
#++

class HeadOfHousehold < ActiveRecord::Base
  # Excludes model from being included in PO template
  require 'gettext/rails'
  untranslate_all

 
  self.table_name = RUBYCAMPUS_HEAD_OF_HOUSEHOLD_TABLE
  has_many :contacts     
    
end
# == Schema Information
# Schema version: 20080902230656
#
# Table name: rubycampus_contacts
#
#  id                                :integer(11)     not null, primary key
#  domain_id                         :integer(11)     default(1), not null
#  stage_id                          :integer(11)
#  entry_term_id                     :integer(11)
#  contact_type_id                   :integer(11)
#  preferred_communication_method_id :integer(11)
#  preferred_email_format_id         :integer(11)
#  source_id                         :integer(11)
#  name_prefix_id                    :integer(11)
#  name_suffix_id                    :integer(11)
#  marital_status_id                 :integer(11)
#  citizenship_id                    :integer(11)
#  nationality_id                    :integer(11)
#  ethnicity_id                      :integer(11)
#  education_level_id                :integer(11)
#  academic_level_id                 :integer(11)
#  gender_id                         :integer(11)
#  country_of_birth_id               :integer(11)
#  greeting_id                       :integer(11)
#  do_not_email                      :boolean(1)
#  do_not_phone                      :boolean(1)
#  do_not_mail                       :boolean(1)
#  do_not_trade                      :boolean(1)
#  is_opt_out                        :boolean(1)
#  legal_identifier                  :string(255)
#  external_identifier               :string(255)
#  nick_name                         :string(255)
#  legal_name                        :string(255)
#  homepage_url                      :string(255)
#  image_url                         :string(255)
#  last_name                         :string(255)
#  first_name                        :string(255)
#  middle_name                       :string(255)
#  phonetic_last_name                :string(255)
#  phonetic_first_name               :string(255)
#  phonetic_middle_name              :string(255)
#  job_title                         :string(255)
#  deceased_date                     :date
#  mail_to_household_id              :integer(11)
#  household_name                    :string(255)
#  head_of_household_id              :integer(11)
#  organization_name                 :string(255)
#  sic_code                          :string(255)
#  user_id                           :integer(11)
#  assigned_to_user_id               :integer(11)
#  lock_version                      :integer(11)     default(0)
#  date_of_birth                     :date
#  government_identification_number  :binary
#  is_foreign                        :boolean(1)
#  is_deceased                       :boolean(1)
#  created_at                        :datetime
#  updated_at                        :datetime
#  last_modified_by_user_id          :integer(11)
#  asset_id                          :integer(11)
#

