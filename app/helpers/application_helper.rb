module ApplicationHelper
  def link_to_add_locations(name, f, association)
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.fields_for(association, new_object, child_index: id) do |builder|
      render('location_fields', f: builder)
    end
    link_to(name, '#', class: "add_fields", data: {id: id, fields: fields.gsub("\n", "")})
  end
  def link_to_add_transportations(url, f, association)
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.fields_for(association, new_object, child_index: id) do |builder|
      render('transportation_fields', f: builder)
    end
    link_to(url, '#', class: "add_fields", data: {id: id, fields: fields.gsub("\n", "")})
  end
  def link_to_add_accomodations(url, f, association)
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.fields_for(association, new_object, child_index: id) do |builder|
      render('accomodation_fields', f: builder)
    end
    link_to(url, '#', class: "add_fields", data: {id: id, fields: fields.gsub("\n", "")})
  end
end
