import app.repository.connection
import app.index

connOrigin = app.repository.connection.Connection(
    "pq://ohne:64jdsSpr9VwUuD@ohne-dev-homolog.crdc5pwhpdzs.us-east-2.rds.amazonaws.com:5432/ohne-development")

connTarget = app.repository.connection.Connection(
    "pq://ohne:64jdsSpr9VwUuD@ohne-dev-homolog.crdc5pwhpdzs.us-east-2.rds.amazonaws.com:5432/ohne-datawarehouse")

getQuery = """
        SELECT 	id AS user_id, 	uuid, 	address_id, 	marital_status_id, 	identity_proof_front_id, 	identity_proof_back_id, 	professional_class_id, 	personal_reference_id, 	name, 	cpf, 	email, 	birthday, 	gender, 	gross_income, 	profession, 	company_name, 	admission_date, 	authorized_verify_email, 	patrimony, 	politically_exposed_person, 	created_at AS user_created_at, 	updated_at AS user_updated_at, 	now() AS created_at FROM users WHERE deleted_at IS NULL AND (created_at >= '{0}' OR updated_at >= '{0}') ORDER BY id
    """

initialValueQuery = """
        SELECT             MAX(created_at)         FROM dim_users;
    """

defaultInitialValue = "2018-01-01"
primaryKey = "user_id"
deleteQuery = "DELETE FROM dim_users WHERE user_id IN({0})"
insertQuery = "INSERT INTO dim_users VALUES"

app.index.process(connOrigin,
                  connTarget,
                  getQuery,
                  initialValueQuery,
                  defaultInitialValue,
                  primaryKey,
                  deleteQuery,
                  insertQuery)
