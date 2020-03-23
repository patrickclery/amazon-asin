import React, {Component} from 'react'
import {Alert, Button, Form, Jumbotron} from 'react-bootstrap';
import ProductsList from "./ProductsList";

class App extends Component {

  constructor(props) {
    super(props);

    this.state = {
      asin:         null,
      errorMessage: null,
      products:     []
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

    // If we get an error, display the error message
    if (json.errors) {
      this.setState({errorMessage: json.errors[0].detail})
    } else {
      this.setState({products: [json.data, ...this.state.products]});
    }
  }

  handleChange(event) {
    this.setState({asin: event.target.value});
  }

  async componentDidMount() {
    const uri = `${this.apiBaseUri}/products/`;

    const response = await fetch(uri);
    const json = await response.json();

    // If we get an error, display the error message
    if (json.errors) {
      this.setState({errorMessage: json.errors[0].detail})
    } else {
      this.setState({products: json.data});
    }
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
            required
          />
          <br/>
          <Button type="submit">Submit</Button>
        </Form>
        <br/>

        {this.state.errorMessage &&
        <Alert variant="danger" onClose={() => this.setState({errorMessage: null})} dismissible>
          <Alert.Heading>Uh-oh! Something went wrong...</Alert.Heading>
          <p>{this.state.errorMessage}</p>
        </Alert>}

        <ProductsList products={this.state.products}/>
      </div>
    );
  }
}

export default App;

