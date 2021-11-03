e1 = Entity.create!(name: 'entity1', labels: 'test', descriptions: 'test')
e2 = Entity.create!(name: 'entity2', labels: 'test', descriptions: 'test', parent: e1)
e3 = Entity.create!(name: 'entity3', labels: 'test', descriptions: 'test', parent: e2)

f1 = Field.create!(name: 'field1', labels: 'test', descriptions: 'test')
f2 = Field.create!(name: 'field2', labels: 'test', descriptions: 'test')
f3 = Field.create!(name: 'field3', labels: 'test', descriptions: 'test')
f4 = Field.create!(name: 'field4', labels: 'test', descriptions: 'test')
f5 = Field.create!(name: 'field5', labels: 'test', descriptions: 'test')
f6 = Field.create!(name: 'field6', labels: 'test', descriptions: 'test')

e1.fields << f1
e1.fields << f2
e2.fields << f3
e2.fields << f4
e3.fields << f5
e3.fields << f6

en1 = Enum.create!(name: 'enum1', labels: 'test', descriptions: 'test')
en2 = Enum.create!(name: 'enum2', labels: 'test', descriptions: 'test')

EnumerationMember.create!(name: 'enum_m1', labels: 'test', descriptions: 'test', enum: en1)
EnumerationMember.create!(name: 'enum_m2', labels: 'test', descriptions: 'test', enum: en1)
EnumerationMember.create!(name: 'enum_m3', labels: 'test', descriptions: 'test', enum: en1)
EnumerationMember.create!(name: 'enum_m4', labels: 'test', descriptions: 'test', enum: en2)
EnumerationMember.create!(name: 'enum_m5', labels: 'test', descriptions: 'test', enum: en2)
EnumerationMember.create!(name: 'enum_m6', labels: 'test', descriptions: 'test', enum: en2)

dt1 = Datatype.create!(name: 'datatype1', labels: 'test', descriptions: 'test')
dt2 = Datatype.create!(name: 'datatype2', labels: 'test', descriptions: 'test')
dt3 = Datatype.create!(name: 'datatype3', labels: 'test', descriptions: 'test')

Option.create!(field: f1, optionable: en1)
Option.create!(field: f2, optionable: dt1)
Option.create!(field: f3, optionable: en2)
Option.create!(field: f4, optionable: dt2)
Option.create!(field: f5, optionable: dt3)
Option.create!(field: f6, optionable: en1)
