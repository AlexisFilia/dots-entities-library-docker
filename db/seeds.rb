e1 = Entity.create!(name: 'entity1')
e2 = Entity.create!(name: 'entity2', parent: e1)
e3 = Entity.create!(name: 'entity3', parent: e2)

f1 = Field.create!(name: 'field1')
f2 = Field.create!(name: 'field2')
f3 = Field.create!(name: 'field3')
f4 = Field.create!(name: 'field4')
f5 = Field.create!(name: 'field5')

ft1 = Fieldtype.create!(name: 'ftum1', type_of: 'datatype')
en1 = Fieldtype.create!(name: 'ftum2', type_of: 'enum')

em1 = EnumerationMember.create!(name: 'enum_m1', fieldtype: en1)
em2 = EnumerationMember.create!(name: 'enum_m2', fieldtype: en1)
em3 = EnumerationMember.create!(name: 'enum_m3', fieldtype: en1)
em4 = EnumerationMember.create!(name: 'enum_m4', fieldtype: en1)
em5 = EnumerationMember.create!(name: 'enum_m5', fieldtype: en1)
em6 = EnumerationMember.create!(name: 'enum_m6', fieldtype: en1)

f1.fieldtypes << ft1
f2.fieldtypes << ft1
f3.fieldtypes << en1
f4.fieldtypes << ft1
f5.fieldtypes << en1

a1 = Action.create!(name: 'action1')
a2 = Action.create!(name: 'action2')
a3 = Action.create!(name: 'action3')
a4 = Action.create!(name: 'action4')
a5 = Action.create!(name: 'action5')
a6 = Action.create!(name: 'action6')

s1 = Section.where(element_type: 'Field').first
s2 = Section.where(element_type: 'Action').first
s3 = Section.where(element_type: 'Field').last
s4 = Section.where(element_type: 'Action').last

SectionElement.create!(section: s1, sectionable: f1)
SectionElement.create!(section: s1, sectionable: f2)
SectionElement.create!(section: s1, sectionable: f3)
SectionElement.create!(section: s1, sectionable: f4)
SectionElement.create!(section: s2, sectionable: a1)
SectionElement.create!(section: s2, sectionable: a2)
SectionElement.create!(section: s3, sectionable: f5)
SectionElement.create!(section: s4, sectionable: a3)

e2.actions << a1
e3.actions << a3
e3.actions << a2
e2.actions << a4
e3.actions << a4
e3.actions << a4

Localizable.create!(type_of: 'description', language: 'Fr', value: 'description Fr 1', localizable: e1)
Localizable.create!(type_of: 'description', language: 'Fr', value: 'description Fr 3', localizable: a1)
Localizable.create!(type_of: 'description', language: 'Fr', value: 'description Fr 4', localizable: f1)
Localizable.create!(type_of: 'description', language: 'Fr', value: 'description Fr 6', localizable: em1)

Localizable.create!(type_of: 'label', language: 'Fr', value: 'label Fr 1', localizable: e1)
Localizable.create!(type_of: 'label', language: 'Fr', value: 'label Fr 3', localizable: a1)
Localizable.create!(type_of: 'label', language: 'Fr', value: 'label Fr 4', localizable: f1)
Localizable.create!(type_of: 'label', language: 'Fr', value: 'label Fr 8', localizable: em1)

Localizable.create!(type_of: 'description', language: 'En', value: 'description En 1', localizable: e1)
Localizable.create!(type_of: 'description', language: 'En', value: 'description En 3', localizable: a1)
Localizable.create!(type_of: 'description', language: 'En', value: 'description En 4', localizable: f1)
Localizable.create!(type_of: 'description', language: 'En', value: 'description En 8', localizable: em1)

Localizable.create!(type_of: 'label', language: 'En', value: 'label En 1', localizable: e1)
Localizable.create!(type_of: 'label', language: 'En', value: 'label En 3', localizable: a1)
Localizable.create!(type_of: 'label', language: 'En', value: 'label En 4', localizable: f1)
Localizable.create!(type_of: 'label', language: 'En', value: 'label En 8', localizable: em1)
