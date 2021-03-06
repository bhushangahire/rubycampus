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

module ApplicationHelper

  # Returns a dashboard panel and its widgets
  def dashboard_panel_receiver(widgets,user,panel)
    val = ''
    cp = case panel
         when 'top' then ""
         when 'left' then "contentpanelleft "
         when 'right' then "contentpanelright "
         end

    widgets[panel].each do |widget|
      next unless DashboardController::WIDGETS.keys.include? widget
      val << render(:partial => 'widget', :locals => {:user => user, :widget_name => widget})
      content_tag(:div, val, :class => "dashboard-box")
    end if widgets[panel]

    <<-EOF
      <div id="list-#{panel}" class="#{cp}widget-receiver">
      #{val}
      </div>
    EOF
  end

  # Sets <body class=""> to controllers name for stylesheet hooks
  def body_tag_classes
    @body_tag_classes ||= [ RUBYCAMPUS, controller.controller_name ]
  end

  # Sets title and optionally <body class="">
  def title(page_title,body_tag_klass=nil)
    if !body_tag_klass.nil?
      body_tag_classes << body_tag_klass
    end
    content_for(:title) { page_title }
  end

  #
  # By default, uses the current controller and action to render the url to the
  # corresponding RubyCampus wiki page.
  #
  def link_to_help(label="Help")
    wiki_page = "#{RUBYCAMPUS_ORG_BASE_URL}wiki/#{RUBYCAMPUS}/"
    case controller.action_name.to_s
      when "index"
        wiki_page << "Managing_#{controller.controller_name.titleize.gsub(" ","_")}"
      when "show"
        wiki_page << "Viewing_An_Existing_#{controller.controller_name.singularize.titleize.gsub(" ","_")}"
      when "new"
        wiki_page << "Creating_A_New_#{controller.controller_name.singularize.titleize.gsub(" ","_")}"
      when "edit"
        wiki_page << "Editing_An_Existing_#{controller.controller_name.singularize.titleize.gsub(" ","_")}"
      else
        wiki_page << "#{controller.controller_name.titleize.gsub(" ","_")}"
      end
    link_to I18n.t(label, :default => "Help"), "#{wiki_page}", :popup => true
  end

  #
  # Should be used in inline help on pages. By default, uses the current controller and action
  # to render the url to the corresponding RubyCampus wiki page.
  #
  def link_to_learn_more
    { :learn_more => link_to_help(I18n.t("Learn more...", :default => "Learn more...")) }
  end

  #
  # Should be called only by context_help from helpers
  #
  def context_help(help_message)
    content_tag :p, (help_message), :class => "quiet"
  end

  # Links to RubyCampus issue tracker and fill basic issue information
  def link_to_tracker_issues_new
    link_to I18n.t("New Issue", :default => "New Issue"), RUBYCAMPUS_ORG_BASE_URL + "projects/#{RUBYCAMPUS}/issues/new", :popup => true
  end

  # Get current controllers name
  def current_controller_human_name
    controller.controller_name.singularize.titleize
  end

  def current_controller_gettext_human_name
    current_controller_human_name
  end

  def current_controller_gettext_human_name_pluralized
    controller.controller_name.titleize
  end

  # Returns a constant based on the controllers name singularlized
  def current_controller_contact_type
   eval = controller.controller_name.upcase.singularize
   case
     when eval == "INDIVIDUAL"
       return ContactType::INDIVIDUAL.id
     when eval == "ORGANIZATION"
       return ContactType::ORGANIZATION.id
     when eval == "HOUSEHOLD"
       return ContactType::HOUSEHOLD.id
     else
       return nil
     end
  end

  # Renders links for views
  def link_to_extract
    link_to I18n.t("PDF", :default => "PDF"), { :action => :extract, :id => params[:id], :format => :pdf }, :class => "positive"
  end

  def link_to_edit
    link_to(I18n.t("Edit", :default => "Edit"), self.send(("edit_"+controller.controller_name.singularize+ "_path")), :class => "positive")
  end

  def link_to_destroy
    link_to(I18n.t("Destroy", :default => "Destroy"), self.send((controller.controller_name.singularize+ "_path")), :class => "negative", :confirm => (I18n.t("Really destroy {{value}}?", :default => "Really destroy {{value}}?", :value => controller.controller_name.titleize)), :method => :delete )
  end

  # Returns true if current contact_type evaluates true
  def current_contact_type_is(contact_type)
    params[:contact_type] == contact_type.to_s
  end

  def current_announcements
    @current_announcements ||= Announcement.current_announcements(session[:announcement_hide_time])
  end

  # Renders hakozaki css class label requiring only the controller name
  #
  # Checks if user is authorized to edit lookup tables and optionally
  # uses :example and :label.
  #
  # :label - overrides the default labeling scheme which uses the controllers name
  # :example - renders a muted notation inline with the label
  #
  # Example:
  #
  # -> label_with_lookup :controller => :name_prefix, :example => I18n.t("Fall 2009"), :label => I18n.t("Prefix", :default => "Prefix")
  def label_with_lookup(opts={})
    controller = opts[:controller]
    example = opts[:example] || ''
    label = opts[:label] || opts[:controller]
    content_tag(:span, (current_user_is_super_user_role && @current_action !='show' ? (link_to label.to_s.titleize, self.send(controller.to_s.underscore.pluralize+"_path")) : label.to_s.titleize) + (content_tag(:span, ' ' + example, :class => "example") unless example == nil) , :class => "title")
  end

  # Returns true if current_user is_admin and/or has_role of administrator
  def current_user_is_super_user_role
    current_user.is_admin || current_user.has_role?('administrator')
  end

  # Returns UL of mergable tokens
  # FIXME Just a mock
  def list_mergable_tokens
      out = "<ul>"
      for token in TOKENS do
        out << content_tag(:li, token, :style => "list-style-type: none")
      end
      out << "</ul>"
  end

  def pagination_links_remote(paginator)
    page_options = {:window_size => 1}
    pagination_links_each(paginator, page_options) do |n|
      options = {
        :url => {:action => 'index', :params => params.merge({:page => n})},
        :update => 'table',
        :before => "Element.show('spinner')",
        :success => "Element.hide('spinner')"
      }
      html_options = {:href => url_for(:action => 'index', :params => params.merge({:page => n}))}
      link_to_remote(n.to_s, options, html_options)
    end
  end

  #
  # Adds contextual sorting class to tag
  #
  def sort_th_class_helper(param)
    result = 'class="sortup"' if params[:sort] == param
    result = 'class="sortdown"' if params[:sort] == param + "_reverse"
    return result
  end

  #
  # Generates link for sorting on provided text
  #
  def sort_link_helper(text, param)
    key = param
    key += "_reverse" if params[:sort] == param
    options = {
        :url => {:action => 'index', :params => params.merge({:sort => key, :page => nil})},
        :update => 'table',
        :before => "Element.show('spinner')",
        :success => "Element.hide('spinner')"
    }
    html_options = {
      :title => I18n.t("Sort by this field", :default => "Sort by this field"),
      :href => url_for(:action => 'index', :params => params.merge({:sort => key, :page => nil}))
    }
    link_to_remote(text, options, html_options)
  end

end
