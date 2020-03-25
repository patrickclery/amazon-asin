import React from "react";
import {Table} from "react-bootstrap";

class ProductsList extends React.Component {
  constructor(props) {
    super(props);
  }

  render() {
    return (
      <React.Fragment>
        <h1>Products</h1>
        <Table striped>
          <thead>
            <tr>
              <th>ASIN</th>
              <th>Title</th>
              <th>Category</th>
              <th>Rank</th>
              <th>Dimensions</th>
            </tr>
          </thead>
          <tbody>
            {this.props.products && this.props.products.map(
              product =>
                <tr key={product.id}>
                  <td><a href={product.attributes.productUrl} target="_blank">{product.attributes.asin}</a></td>
                  <td>{product.attributes.productTitle}</td>
                  <td><a href={product.attributes.categoryUrl}>{product.attributes.categoryName}</a>
                  </td>
                  <td>{product.attributes.rank}</td>
                  <td>{product.attributes.dimensions}</td>
                </tr>
            )}
          </tbody>
        </Table>
      </React.Fragment>
    );
  }
}

export default ProductsList
