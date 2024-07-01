#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

GET_ELEMENT_INFO(){
  if [[ ! $1 =~ ^[0-9]+$ ]]
  then
    RESULTS=$($PSQL "SELECT elements.atomic_number,elements.name,elements.symbol,properties.atomic_mass,properties.melting_point_celsius,properties.boiling_point_celsius,types.type
              FROM elements JOIN properties ON elements.atomic_number = properties.atomic_number 
              JOIN types ON properties.type_id = types.type_id
              WHERE elements.symbol = '$1' OR elements.name = '$1' LIMIT 1")
  else
    RESULTS=$($PSQL "SELECT elements.atomic_number,elements.name,elements.symbol,properties.atomic_mass,properties.melting_point_celsius,properties.boiling_point_celsius,types.type
              FROM elements JOIN properties ON elements.atomic_number = properties.atomic_number 
              JOIN types ON properties.type_id = types.type_id
              WHERE elements.atomic_number = $1 LIMIT 1")
  fi
  if [[ -z "$RESULTS" ]];  then
    echo -e "I could not find that element in the database."
    exit 0
  else
    echo "$RESULTS" | while IFS="|" read -r ATOMIC_NUMBER NAME SYMBOL ATOMIC_MASS MELTING_POINT BOILING_POINT TYPE
    do
    echo -e "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
    done
  fi
}

FIX_DB(){
    RENAME_WEIGHT=$($PSQL "ALTER TABLE properties RENAME COLUMN weight TO atomic_mass;")
    echo "RENAME_WEIGHT : $RENAME_WEIGHT"

    RENAME_MELTING_POINT=$($PSQL"ALTER TABLE properties RENAME COLUMN melting_point TO melting_point_celsius;")
    RENAME_BOILING_POINT=$($PSQL"ALTER TABLE properties RENAME COLUMN boiling_point TO boiling_point_celsius;")
    echo "RENAME_MELTING_POINT  : $RENAME_MELTING_POINT"
    echo "RENAME_BOILING_POINT  : $RENAME_BOILING_POINT"

    ALTER_MELTING_POINT_NOT_NULL=$($PSQL"ALTER TABLE properties ALTER COLUMN melting_point_celsius SET NOT NULL;")
    ALTER_BOILING_POINT_NOT_NULL=$($PSQL "ALTER TABLE properties ALTER COLUMN boiling_point_celsius SET NOT NULL;")
    echo "ALTER_MELTING_POINT_NOT_NULL : $ALTER_MELTING_POINT_NOT_NULL"
    echo "ALTER_BOILING_POINT_NOT_NULL : $ALTER_BOILING_POINT_NOT_NULL"

    ALTER_ELEMENTS_SYMBOL=$($PSQL "ALTER TABLE elements ALTER COLUMN symbol SET NOT NULL, ADD CONSTRAINT symbol UNIQUE (symbol);")
    ALTER_ELEMENTS_NAME=$($PSQL "ALTER TABLE elements ALTER COLUMN name SET NOT NULL, ADD CONSTRAINT name UNIQUE (name);")
    echo "ALTER_ELEMENTS_SYMBOL  : $ALTER_ELEMENTS_SYMBOL"
    echo "ALTER_ELEMENTS_NAME   : $ALTER_ELEMENTS_NAME"

    ALTER_PROPERTIES_ATOMIC_NUMBER_FOREIGN_KEY=$($PSQL "ALTER TABLE properties ADD FOREIGN KEY (atomic_number) REFERENCES elements(atomic_number);")
    echo "ALTER_PROPERTIES_ATOMIC_NUMBER_FOREIGN_KEY  : $ALTER_PROPERTIES_ATOMIC_NUMBER_FOREIGN_KEY"

    CREATE_TABEL_TYPES=$($PSQL "CREATE TABLE types();")
    echo "CREATE_TABEL_TYPES : $CREATE_TABEL_TYPES"

    ADD_COLUMN_TYPES_TYPE_ID=$($PSQL "ALTER TABLE types ADD COLUMN type_id SERIAL PRIMARY KEY;")
    echo "ADD_COLUMN_TYPES_TYPE_ID  : $ADD_COLUMN_TYPES_TYPE_ID"
    ADD_COLUMN_TYPES_TYPE=$($PSQL "ALTER TABLE types ADD COLUMN type VARCHAR(20) NOT NULL;")
    echo "ADD_COLUMN_TYPES_TYPE  : $ADD_COLUMN_TYPES_TYPE"
    INSERT_COLUMN_TYPES_TYPE=$($PSQL "INSERT INTO types(type) SELECT DISTINCT(type) FROM properties;")
    echo "INSERT_COLUMN_TYPES_TYPE  : $INSERT_COLUMN_TYPES_TYPE"

    ADD_COLUMN_PROPERTIES_TYPE_ID=$($PSQL "ALTER TABLE properties ADD COLUMN type_id INT;")
    echo "ADD_COLUMN_PROPERTIES_TYPE_ID  : $ADD_COLUMN_PROPERTIES_TYPE_ID"
    ADD_FOREIGN_KEY_PROPERTIES_TYPE_ID=$($PSQL "ALTER TABLE properties ADD FOREIGN KEY(type_id) REFERENCES types(type_id);")
    echo "ADD_FOREIGN_KEY_PROPERTIES_TYPE_ID  : $ADD_FOREIGN_KEY_PROPERTIES_TYPE_ID"
    UPDATE_PROPERTIES_TYPE_ID=$($PSQL "UPDATE properties SET type_id = (SELECT type_id FROM types WHERE properties.type = types.type);")
    echo "UPDATE_PROPERTIES_TYPE_ID : $UPDATE_PROPERTIES_TYPE_ID"
    ALTER_COLUMN_PROPERTIES_TYPE_ID_NOT_NULL=$($PSQL "ALTER TABLE properties ALTER COLUMN type_id SET NOT NULL;")
    echo "ALTER_COLUMN_PROPERTIES_TYPE_ID_NOT_NULL : $ALTER_COLUMN_PROPERTIES_TYPE_ID_NOT_NULL"

    UPDATE_ELEMENTS_SYMBOL=$($PSQL "UPDATE elements SET symbol = CONCAT(UPPER(SUBSTRING(symbol, 1, 1)), LOWER(SUBSTRING(symbol, 2)));")
    echo "UPDATE_ELEMENTS_SYMBOL : $UPDATE_ELEMENTS_SYMBOL"

    ALTER_ATOMIC_MASS_TYPE=$($PSQL "ALTER TABLE properties ALTER COLUMN atomic_mass TYPE DECIMAL;")
    echo "ALTER_ATOMIC_MASS_TYPE  : $ALTER_ATOMIC_MASS_TYPE"
    TRAILING_ATOMIC_MASS=$($PSQL "UPDATE properties SET atomic_mass = TRIM(TRAILING '0' FROM TO_CHAR(atomic_mass, 'FM999999999.999999999'))::DECIMAL;")
    echo "TRAILING_ATOMIC_MASS   :  $TRAILING_ATOMIC_MASS"

    INSERT_INTO_ELEMENTS=$($PSQL "INSERT INTO elements(atomic_number,symbol,name) VALUES(9,'F','Fluorine'),(10,'Ne','Neon');")
    echo "INSERT_INTO_ELEMENTS  : $INSERT_INTO_ELEMENTS"
    INSERT_INTO_PROPERTIES=$($PSQL "INSERT INTO properties(atomic_number,type,atomic_mass,melting_point_celsius,boiling_point_celsius,type_id) VALUES(9,'nonmetal',18.998,-220,-188.1,3),(10,'nonmetal',20.18,-248.6,-246.1,3);")
    echo "INSERT_INTO_PROPERTIES  :  $INSERT_INTO_PROPERTIES"

    DELETE_PROPERTIES_1000=$($PSQL "DELETE FROM properties WHERE atomic_number=1000;")
    DELETE_ELEMENTS_1000=$($PSQL "DELETE FROM elements WHERE atomic_number=1000;")
    echo "DELETE_PROPERTIES_1000   : $DELETE_PROPERTIES_1000"
    echo "DELETE_ELEMENTS_1000    : $DELETE_ELEMENTS_1000"  
 
    DELETE_COLUMN_PROPERTIES_TYPE=$($PSQL "ALTER TABLE properties DROP COLUMN type;")
    echo "DELETE_COLUMN_PROPERTIES_TYPE   : $DELETE_COLUMN_PROPERTIES_TYPE"

}

START_PROGRAM(){
if [ $# -eq 0 ]; then
    echo "Please provide an element as an argument."
    exit 0
else
  CHECK=$($PSQL "SELECT COUNT(*) FROM elements WHERE atomic_number=1000")
  if [[ $CHECK -gt 0 ]]
  then
  FIX_DB
  clear
  fi
  GET_ELEMENT_INFO "$1"
fi

}

START_PROGRAM $1