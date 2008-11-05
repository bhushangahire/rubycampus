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

require File.dirname(__FILE__) + '/../spec_helper'

module MailingMixinSpecHelper
  def valid_mailing_mixin_attributes
    {
      :name => "Mailing Header",
      :mailing_mixin_type_name => "Header",
      :subject => "Descriptive Title for this Header",
      :html => "Sample Header for HTML formatted content.",
      :text => "Sample Header for TEXT formatted content."
    }
  end
end

describe MailingMixin do
  
  include MailingMixinSpecHelper
  
  before(:each) do
    @mailing_mixin = MailingMixin.new
  end
  
  it "should be valid" do
    @mailing_mixin.attributes = valid_mailing_mixin_attributes
    @mailing_mixin.should be_valid
  end
  
  it "should require name" do
    @mailing_mixin.should have(1).error_on(:name)
  end
  
  it "should require mailing mixin type name" do
    @mailing_mixin.should have(1).error_on(:mailing_mixin_type_name)
  end
  
  it "should require subject" do
    @mailing_mixin.should have(1).error_on(:subject)
  end 
  
  it "should not require html message" do
    @mailing_mixin.should have(0).error_on(:html)
  end
  
  it "should require text message" do
    @mailing_mixin.should have(1).error_on(:text)
  end
  
end