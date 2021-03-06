
-- CREATE TABLE IF NOT EXISTS work with HSQLDB 2.3.x

--
CREATE TABLE users (
  username VARCHAR_IGNORECASE(50)  NOT NULL PRIMARY KEY,
  password VARCHAR_IGNORECASE(500) NOT NULL,
  enabled  BOOLEAN                 NOT NULL
);

--
CREATE TABLE authorities (
  username  VARCHAR_IGNORECASE(50) NOT NULL,
  authority VARCHAR_IGNORECASE(50) NOT NULL,
  CONSTRAINT fk_authorities_users FOREIGN KEY (username) REFERENCES users (username)
);

CREATE UNIQUE INDEX ix_auth_username
  ON authorities (username, authority);

-- see: spring-security/config/src/test/resources/CustomJdbcUserServiceSampleConfig.sql
--
CREATE TABLE groups (
  id bigint GENERATED BY DEFAULT AS IDENTITY(START WITH 0) PRIMARY KEY,
  group_name VARCHAR_IGNORECASE(50) NOT NULL
);

--
CREATE TABLE group_authorities (
  group_id bigint NOT NULL,
  authority VARCHAR(50) NOT NULL,
  CONSTRAINT fk_group_authorities_group FOREIGN KEY(group_id) REFERENCES groups(id)
);

--
CREATE TABLE group_members (
  id BIGINT GENERATED BY DEFAULT AS IDENTITY(START WITH 0) PRIMARY KEY,
  username VARCHAR(50) NOT NULL,
  group_id bigint NOT NULL,
  CONSTRAINT fk_group_members_group FOREIGN KEY(group_id) REFERENCES groups(id)
);

-- see: spring-security/acl/src/main/resources/createAclSchema.sql
-- see: spring-security/acl/src/main/resources/createAclSchemaMySQL.sql
-- see: spring-security/acl/src/main/resources/createAclSchemaPostgres.sql
