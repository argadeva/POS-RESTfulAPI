const productsModel = require("../models/products"),
  miscHelper = require("../helpers/message");

const fs = require("fs");
const { promisify } = require("util");
const unlinkAsync = promisify(fs.unlink);

module.exports = {
  getProducts: (req, res) => {
    productsModel
      .getProducts()
      .then(result => {
        miscHelper.response(res, result, "Success", 200);
      })
      .catch(err => console.log(err));
  },
  detailProducts: (req, res) => {
    const id_product = req.params.id_product;
    productsModel
      .detailProducts(id_product)
      .then(result => {
        if (result.length !== 0) {
          miscHelper.response(res, result, "Success", 200);
        } else {
          miscHelper.response(res, "", "Product ID not found!", 400);
        }
      })
      .catch(err => console.log(err));
  },
  addProducts: (req, res) => {
    const { name, description, price, category_id } = req.body;
    const data = {
      name,
      description,
      price,
      image:
        typeof req.file !== "undefined"
          ? `${process.env.URL}uploads/${req.file.filename}`
          : null,
      stock: 0,
      category_id
    };
    productsModel
      .addProducts(data)
      .then(result => {
        miscHelper.response(res, result, "Product created successfully!", 200);
      })
      .catch(err => console.log(err));
  },
  editProducts: (req, res) => {
    const id_product = req.params.id_product;
    const { name, description, price, category_id } = req.body;

    const data = {
      name,
      description,
      price,
      category_id
    };

    if (typeof req.file !== "undefined") {
      productsModel
        .detailProducts(id_product)
        .then(result => {
          unlinkAsync(result[0].image.replace(process.env.URL, ""));
        })
        .catch(err => console.log(err));
      Object.assign(data, {
        image: `${process.env.URL}uploads/${req.file.filename}`
      });
    } else {
      productsModel
        .detailProducts(id_product)
        .then(result => {
          unlinkAsync(result[0].image.replace(process.env.URL, ""));
        })
        .catch(err => console.log(err));
      Object.assign(data, {
        image: ""
      });
    }
    productsModel
      .detailProducts(id_product)
      .then(result => {
        if (result.length !== 0) {
          productsModel
            .editProducts(id_product, data)
            .then(result => {
              miscHelper.response(res, "", "Product edited successfully!", 200);
            })
            .catch(err => console.log(err));
        } else {
          miscHelper.response(res, "", "Product ID not found!", 400);
        }
      })
      .catch(err => console.log(err));
  },
  deleteProducts: (req, res) => {
    const id_product = req.params.id_product;
    productsModel
      .detailProducts(id_product)
      .then(result => {
        if (result.length !== 0) {
          productsModel
            .detailProducts(id_product)
            .then(result => {
              if (result[0].image === null) {
                productsModel
                  .deleteProducts(id_product)
                  .then(results => {
                    miscHelper.response(
                      res,
                      results,
                      "Product deleted successfully!",
                      200
                    );
                  })
                  .catch(err => console.log(err));
              } else {
                productsModel
                  .deleteProducts(id_product)
                  .then(results => {
                    unlinkAsync(result[0].image.replace(process.env.URL, ""));
                    miscHelper.response(
                      res,
                      results,
                      "Product deleted successfully!",
                      200
                    );
                  })
                  .catch(err => console.log(err));
              }
            })
            .catch(err => console.log(err));
        } else {
          miscHelper.response(res, "", "Product ID not found!", 400);
        }
      })
      .catch(err => console.log(err));
  },
  searchProducts: (req, res) => {
    const search = req.params.search;
    productsModel
      .searchProducts(search)
      .then(result => {
        if (result.length !== 0) {
          miscHelper.response(res, result, "Success", 200);
        } else {
          miscHelper.response(res, "", "Product name search not found!", 400);
        }
      })
      .catch(err => console.log(err));
  },
  sortProducts: (req, res) => {
    const sort = req.params.sort;
    productsModel
      .sortProducts(sort)
      .then(result => {
        miscHelper.response(res, result, "Success", 200);
      })
      .catch(err =>
        miscHelper.response(res, "", "Product sort key not found!", 400)
      );
  },
  pageProducts: (req, res) => {
    const page = req.params.page;
    productsModel
      .pageProducts(page)
      .then(result => {
        miscHelper.response(res, result, "Success", 200);
      })
      .catch(err => console.log(err));
  }
};
