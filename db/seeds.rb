# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)



puts "Hello Wot!"
puts "自动建立一个账号，饼创建20个groups，每个group各30个post"

create_account=User.create([email:'23805851@qq.com',password:'111111',password_confirmation:'111111',name:'测试账号'])

create_groups = for i in 1..20 do 
	Group.create!([title:"Group no.#{i}",description: "这是种子建立的第#{i}个groups", user_id:"1"])
	GroupUser.create(group_id: i, user_id:1)
	for k in 1..30 do
	  Post.create!([group_id:"#{i}",content: "这是种子建立的第#{k}个post",user_id:"1"])
	end
      end


















