#--                                                  /THIS FILE IS A PART OF RUBYCAMPUS/
# +------------------------------------------------------------------------------------+
# | RubyCampus - Student & Alumni Relationship Management Software                     |
# +------------------------------------------------------------------------------------+
# | Copyright © 2008-2009 Kevin R. Aleman. Fukuoka, Japan. All Rights Reserved.        |
# +------------------------------------------------------------------------------------+
# |                                                                                    |
# | This program is free software; you can redistribute it and/or modify it under the  |
# | terms of the GNU Affero General Public License version 3 as published by the Free  |
# | Software Foundation with the addition of the following permission added to Section |
# | 15 as permitted in Section 7(a): FOR ANY PART OF THE COVERED WORK IN WHICH THE     |
# | COPYRIGHT IS OWNED BY KEVIN R ALEMAN, KEVIN R ALEMAN DISCLAIMS THE WARRANTY OF NON |
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
# | You can contact the author Kevin R. Aleman by email at KALEMAN@RUBYCAMPUS.ORG. The |
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

class CreatePermissions < ActiveRecord::Migration
  def self.up
    create_table :permissions do |t|
    t.integer      :user_id, :null => false
    t.integer      :role_id, :null => false
    t.integer      :updated_by
    t.boolean      :is_reserved, :default => false
    t.timestamps
    end

    Role.create(:name => 'administrator')
    Role.create(:name => 'supervisor')
    Role.create(:name => 'staff')

    user = User.new
    user.login = "admin"
    user.email = "admin@rubycampus.local"
    user.name = "Administrator"
    user.password = "rubycampus"
    user.password_confirmation = "rubycampus"
    user.time_zone = "Tokyo"
    user.is_admin = true
    user.save(false)
    user.send(:activate!)

    role = Role.find_by_name('administrator')
    user = User.find_by_login('admin')

    permission = Permission.new
    permission.role_id = role
    permission.user_id = user
    permission.save(false)
  end

  def self.down
    drop_table :permissions
    Role.find_by_name('administrator').destroy
    User.find_by_login('admin').destroy
  end
end
