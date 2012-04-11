module ApplicationHelper
  
  
  def menu_builder(page_id)
     tabs = ['events','locations','account']
     content = ""
     tabs.each do |tab|
       content << if page_id == tab
         content_tag('li', content_tag('a', tab, :href => nil ), :class => 'active')
       else
         content_tag('li', content_tag('a', tab, :href => "/#{tab}" ), :class => 'inactive')
       end
     end

     content_tag(:ul, content, :class => 'tabnav')

   end
  
end
