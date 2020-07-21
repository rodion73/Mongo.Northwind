function import($sql, $col) {
    if(Test-Path $sql) {
        sqlcmd -S . -d Northwind -E -i $sql -y 0 -f 65001 | join-string |
            ssh asgard.home.arpa `
            docker exec -i pet_mongo_1 `
            mongoimport --db northwind --username root --password P@ssw0rd -c $col `
                --authenticationDatabase admin --jsonArray
    }
}

import Categories.sql categories
import Products.sql products
import Customers.sql customers
import Orders.sql orders
