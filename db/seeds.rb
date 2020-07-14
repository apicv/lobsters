User.create(:username => "test", :email => "test@example.com", :password => "test", :password_confirmation => "test", :is_admin => true, :is_moderator => true)
puts "created user: test, password: test"
puts "created tag: test"
User.create(:username => "test2", :email => "test@example.co2m", :password => "test", :password_confirmation => "test", :is_admin => true, :is_moderator => true)
puts "created user: test2, password: test2"

Tag.create(tag:"eso", description:"Recursos relativos a la ESO", privileged:false, is_media:true)
Tag.create(tag:"bachillerato", description:"Recursos relativos a Bachillerato", privileged:false, is_media:true)
Tag.create(tag:"gm", description:"Recursos relativos a Grado Medio", privileged:false, is_media:true)
Tag.create(tag:"gs", description:"Recursos relativos a Grado Superior", privileged:false, is_media:true)
Tag.create(tag:"fpb", description:"Recursos relativos a la Formación Profesional Básica", privileged:false, is_media:true)
