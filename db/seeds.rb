# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Fish.create(
  [
    {
      name: 'ハゼ',
      level: '1',
      season_begin:'2020-06-01',
      season_end:'2020-10-01',
    },
    {
      name: 'アナハゼ',
      level: '1',
      season_begin:'2020-06-01',
      season_end:'2020-10-01',
    },
    {
      name: 'メバル',
      level: '1',
      season_begin:'2020-12-01',
      season_end:'2020-06-01',
    },
    {
      name: 'ソイ',
      level: '1',
      season_begin:'',
      season_end:'',
    },
    {
      name: 'カサゴ',
      level: '1',
      season_begin:'2020-11-01',
      season_end:'2020-05-01',
    },
    {
      name: 'アジ',
      level: '2',
      season_begin:'',
      season_end:'',
    },
    {
      name: 'カマス',
      level: '2',
      season_begin:'2020-09-01',
      season_end:'2020-12-01',
    },
    {
      name: 'メッキ',
      level: '2',
      season_begin:'2020-08-01',
      season_end:'2020-12-01',
    },
     {
      name: 'イワシ',
      level: '2',
      season_begin:'',
      season_end:'',
    },
    {
      name: 'キス',
      level: '2',
      season_begin:'2020-06-01',
      season_end:'2020-12-01',
    },
    {
      name: 'サバ',
      level: '2',
      season_begin:'2020-06-01',
      season_end:'2020-12-01',
    },
    {
      name: 'イカ',
      level: '2',
      season_begin:'2020-12-01',
      season_end:'2020-05-01',
    },
     {
      name: 'タチウオ',
      level: '3',
      season_begin:'2020-08-01',
      season_end:'2020-12-01',
    },
    {
      name: 'サヨリ',
      level: '3',
      season_begin:'2020-06-01',
      season_end:'2020-11-01',
    },
     {
      name: 'カワハギ',
      level: '3',
      season_begin:'2020-10-01',
      season_end:'2020-03-01',
    },
     {
      name: 'アナゴ',
      level: '3',
      season_begin:'2020-10-01',
      season_end:'2020-03-01',
    },
    {
      name: 'アイナメ',
      level: '3',
      season_begin:'2020-10-01',
      season_end:'2020-03-01',
    },
    {
      name: 'タコ',
      level: '3',
      season_begin:'2020-06-01',
      season_end:'2020-11-01',
    },
    {
      name: 'クロダイ',
      level: '3',
      season_begin:'2020-06-01',
      season_end:'2020-08-01',
    },
     {
      name: 'チヌ',
      level: '3',
      season_begin:'2020-06-01',
      season_end:'2020-08-01',
    },
    {
      name: 'メバル',
      level: '3',
      season_begin:'2020-11-01',
      season_end:'2020-06-01',
    },
    {
      name: 'シーバス',
      level: '3',
      season_begin:'2020-02-01',
      season_end:'2020-05-01',
    },
    {
      name: 'スズキ',
      level: '3',
      season_begin:'2020-02-01',
      season_end:'2020-05-01',
    },
    {
      name: 'マゴチ',
      level: '3',
      season_begin:'2020-06-01',
      season_end:'2020-11-01',
    },
    {
      name: ' アオリイカ',
      level: '3',
      season_begin:'2020-06-01',
      season_end:'2020-09-01',
    },
    {
      name: 'ハマチ',
      level: '4',
      season_begin:'',
      season_end:'',
    },
    {
      name: 'サゴシ',
      level: '4',
      season_begin:'',
      season_end:'',
    },
    {
      name: 'カレイ',
      level: '4',
      season_begin:'2020-11-01',
      season_end:'2020-05-01',
    },
    {
      name: 'サワラ',
      level: '4',
      season_begin:'2020-03-01',
      season_end:'2020-12-01',
    },
    {
      name: 'ヒラメ',
      level: '4',
      season_begin:'',
      season_end:'',
    },
    {
      name: 'ヒラスズキ',
      level: '4',
      season_begin:'',
      season_end:'',
    },
    {
      name: 'ハタ',
      level: '4',
      season_begin:'2020-06-01',
      season_end:'2020-11-01',
    },
    {
      name: 'マダイ',
      level: '4',
      season_begin:'2020-03-01',
      season_end:'2020-11-01',
    },
    {
      name: 'メジナ',
      level: '4',
      season_begin:'2020-1-01',
      season_end:'2020-04-01',
    },
    {
      name: 'ヒラメ',
      level: '4',
      season_begin:'2020-09-01',
      season_end:'2020-06-01',
    },
    {
      name: 'シイラ',
      level: '4',
      season_begin:'',
      season_end:'',
    },
    {
      name: 'ブリ',
      level: '5',
      season_begin:'2020-06-01',
      season_end:'2020-12-01',
    },
    {
      name: 'カンパチ',
      level: '5',
      season_begin:'2020-06-01',
      season_end:'2020-12-01',
    },
    {
      name: 'ヒラマサ',
      level: '5',
      season_begin:'',
      season_end:'',
    },
    {
      name: 'アカメ',
      level: '5',
      season_begin:'',
      season_end:'',
    },
  ]
)

User.create(
    [
    {
      name: 'test1',
      email:'test1@gmail.com',
      address:'兵庫県',
      password:"test1",
    },
    {
      name: 'test2',
      email:'test2@gmail.com',
      address:'兵庫県',
      password:"test2",
    },
    {
      name: 'test3',
      email:'test3@gmail.com',
      address:'兵庫県',
      password:"test3",
    },
    {
      name: 'test4',
      email:'test4@gmail.com',
      address:'兵庫県',
      password:"test4",
    },
    {
      name: 'test4',
      email:'test4@gmail.com',
      address:'兵庫県',
      password:"test4",
    },
    {
      name: 'test5',
      email:'test5@gmail.com',
      address:'兵庫県',
      password:"test5",
    },
    {
      name: 'test6',
      email:'test6@gmail.com',
      address:'兵庫県',
      password:"test6",
    },
    {
      name: 'test7',
      email:'test7@gmail.com',
      address:'兵庫県',
      password:"test7",
    },
    {
      name: 'test8',
      email:'test8@gmail.com',
      address:'兵庫県',
      password:"test8",
    },
    {
      name: 'test9',
      email:'test9@gmail.com',
      address:'兵庫県',
      password:"test9",
    },
    {
      name: 'test10',
      email:'test10@gmail.com',
      address:'兵庫県',
      password:"test10",
    }
    ]
)