A basic model for "social kernel" database and back-end, to be implemented in [PostgreSQL 9.6+](https://www.postgresql.org/docs/current/static/functions-json.html) and [Java Spring-Boot framework](http://projects.spring.io/spring-boot/)... Testing limits of the [Object-Relational mapping](https://en.wikipedia.org/wiki/Object-relational_mapping), and showing best practices.

It is a simple model of an usual database: a person+organization contact catalogue (the core of any [CRM](https://en.wikipedia.org/wiki/Customer_relationship_management))... With precise information and a [RDF semantic](https://en.wikipedia.org/wiki/Resource_Description_Framework). The basic entities are defined in [SchemaOrg](https://schema.org/):

* **_Person_**: any [sc:Person](https://schema.org/Person) with a [name](https://schema.org/name) and a valid [sc:vatID](https://schema.org/vatID).

* **_Organization_**: any [sc:Organization](https://schema.org/Organization) with a  [name](https://schema.org/name) and a valid [sc:vatID](https://schema.org/vatID).

* **_Agent_**: a generalization of Person and Organization (the union of both), as "formal person" ([wd:legal person](https://www.wikidata.org/wiki/Q3778211) and [wd:natural person](https://www.wikidata.org/wiki/Q154954)).  See [foaf:Agent](http://xmlns.com/foaf/spec/#term_Agent) definition.

* **_TeleCom_**: information about telecommunication-[sc:ContactPoint](https://schema.org/ContactPoint) of an _Agent_. Telephone, e-mail, homepage, etc. addresses.

Optional implementation: we will discuss also the agent-agent relationships that enhance the informations of the catalogue. Examples:

Relation type | *rule* examples (of SchemaOrg)
------------ | -------------
Organization-Organization      | [subOrganization](https://schema.org/subOrganization), [sponsor](https://schema.org/sponsor), ...
Organization-Person   | [founder](https://schema.org/founder), [employee](https://schema.org/employee), [sponsor](https://schema.org/sponsor), [affiliation](https://schema.org/affiliation), ...
Person-Person | [children](https://schema.org/children), [follows](https://schema.org/follows), ...

## Objective
To implement this model **with good Java and good SQL**, 

![](https://yuml.me/76e02566)

And enhance with

![](https://yuml.me/88fec87c)

##  Methodology

The aim is to obtain both, **good Java and good SQL**. 

1. Try with [Spring Roo base-dbre (reverse engineer)](http://docs.spring.io/spring-roo/docs/current/reference/html/base-dbre.html), usign [step1.sql](https://github.com/ppKrauss/socker/blob/master/step1.sql) as reference... Is ok?

2. Try with full construction by Spring Roo (as samples do)... Is Ok? 

3. Try "by hand" [Spring Boot development](http://docs.spring.io/spring-boot/docs/current/reference/html/getting-started-first-application.html).

## Preparing and working

Supposing a [prepared env with PostgreSQL, Roo1 and Roo2](https://github.com/ppKrauss/dummy-java-spring#roo), the first step is to obtain a sample of the database, defined in [step1.sql](step1.sql):

```sh
cd ~
git clone https://github.com/ppKrauss/socKer.git
cd socKer
psql -h localhost -U postgres postgres < step1.sql
```

### roo1try1

Using Roo1 as command `roo`  and the project's folder */roo1try1*, to try method-1:

```sh
cd roo1try1
roo < step1.roo
```
As another Roo1 projects, need to edit conection, eg. with `nano src/main/resources/META-INF/spring/database.properties`
adding the lines of `spring.jpa`,

```
spring.jpa.hibernate.naming.strategy=org.hibernate.cfg.ImprovedNamingStrategy
spring.jpa.hibernate.ddl-auto=create-drop
```
To test and log the database introspection, run `roo < step2.roo > logIntrospect.txt`... Where we can see the first problem with Roo1, that not recognizes the commom sequences of IDs in the tables person and organization (see `socker.agent_id_seq` at database). We will try to correct this problem "by hand" later, let's check what Roo1 can do with all schema with `database reverse engineer` command in step3,

```
roo < step3.roo > step3.log
```

### roo1try2
...


### roo2try2
...

## RESULTS

See all dumps at [DUMPs](DUMPs) folder.
