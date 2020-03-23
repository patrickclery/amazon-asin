import React, {Component} from 'react'
import {Button, Form, Jumbotron} from 'react-bootstrap';
import ProductsList from "./ProductsList";

class App extends Component {

  constructor(props) {
    super(props);

    this.state = {
      asin:           null,
      products:       []
    };

    this.apiBaseUri = "/api/v1";
    this.handleSubmit = this.handleSubmit.bind(this);
    this.handleChange = this.handleChange.bind(this);
  }

  async handleSubmit(event) {
    event.preventDefault();

    const uri = `${this.apiBaseUri}/products/`;
    const requestOptions = {
      method:  'POST',
      headers: {'Content-Type': 'application/json'},
      body:    JSON.stringify({asin: this.state.asin})
    };

    const response = await fetch(uri, requestOptions);
    const json = await response.json();
    this.setState({products: [...this.state.products, json.data]});
  }

  handleChange(event) {
    this.setState({asin: event.target.value});
  }

  async componentDidMount() {
    const uri = `${this.apiBaseUri}/products/`;

    const response = await fetch(uri);
    const json = await response.json();
    this.setState({products: json.data});
  }

  render() {
    return (
      <div className="container m-3">

        <Jumbotron>
          <h1>Amazon ASIN Lookup</h1>
          <p>Made by <a href="https://github.com/patrickclery">Patrick Clery</a> for JungleScout</p>
        </Jumbotron>

        <Form onSubmit={this.handleSubmit}>
          <Form.Control
            size="lg"
            type="text"
            placeholder="Enter an ASIN number"
            onChange={this.handleChange}
          />
          <br/>
          <Button type="submit">Submit</Button>
        </Form>
        <br/>
        <ProductsList products={this.state.products}/>
      </div>
    );
  }
}

export default App;

