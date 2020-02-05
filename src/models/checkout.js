const connection = require("../configs/db");

module.exports = {
  getCheckout: () => {
    return new Promise((resolve, reject) => {
      connection.query(
        "SELECT t1.id, t1.order_number, SUM(qty * price) sub_total, SUM(qty * price) * 10 / 100 ppn, SUM(qty * price) + SUM(qty * price) * 10 / 100 total, t1.created_at, t1.user_id, t3.name FROM checkout t1 INNER JOIN checkout_detail t2 ON t1.id = t2.order_id INNER JOIN users t3 ON t1.user_id = t3.id GROUP BY id",
        (err, result) => {
          if (!err) {
            resolve(result);
          } else {
            reject(new Error(err));
          }
        }
      );
    });
  },
  getCheckoutbyId: id_users => {
    return new Promise((resolve, reject) => {
      connection.query(
        "SELECT t1.id, t1.order_number, SUM(qty * price) sub_total, SUM(qty * price) * 10 / 100 ppn, SUM(qty * price) + SUM(qty * price) * 10 / 100 total, t1.created_at, t1.user_id, t3.name FROM checkout t1 INNER JOIN checkout_detail t2 ON t1.id = t2.order_id INNER JOIN users t3 ON t1.user_id = t3.id WHERE t1.user_id = ?",
        id_users,
        (err, result) => {
          if (!err) {
            resolve(result);
          } else {
            reject(new Error(err));
          }
        }
      );
    });
  },
  getCheckoutDetail: id_checkout => {
    return new Promise((resolve, reject) => {
      connection.query(
        "SELECT t1.id, t1.order_number, SUM(qty * price) sub_total, SUM(qty * price) * 10 / 100 ppn, SUM(qty * price) + SUM(qty * price) * 10 / 100 total, t1.created_at, t1.user_id, t3.name FROM checkout t1 INNER JOIN checkout_detail t2 ON t1.id = t2.order_id INNER JOIN users t3 ON t1.user_id = t3.id WHERE t1.user_id = ?",
        id_checkout,
        (err, result) => {
          if (!err) {
            resolve(result);
          } else {
            reject(new Error(err));
          }
        }
      );
    });
  },
  getProductList: id_checkout => {
    return new Promise((resolve, reject) => {
      connection.query(
        "SELECT checkout_detail.* FROM checkout_detail WHERE order_id = ?",
        id_checkout,
        (err, result) => {
          if (!err) {
            resolve(result);
          } else {
            reject(new Error(err));
          }
        }
      );
    });
  },
  addCheckout: data => {
    return new Promise((resolve, reject) => {
      connection.query("INSERT INTO checkout SET ?", data, (err, result) => {
        if (!err) {
          resolve(result);
        } else {
          reject(new Error(err));
        }
      });
    });
  },
  addCart: data => {
    return new Promise((resolve, reject) => {
      connection.query(
        "INSERT INTO checkout_detail SET ?",
        data,
        (err, result) => {
          if (!err) {
            resolve(result);
            connection.query(
              "UPDATE products SET stock = stock - ? WHERE id = ?",
              [data.qty, data.product_id],
              (err, result) => {
                if (!err) {
                  resolve(result);
                } else {
                  reject(new Error(err));
                }
              }
            );
          } else {
            reject(new Error(err));
          }
        }
      );
    });
  }
};
