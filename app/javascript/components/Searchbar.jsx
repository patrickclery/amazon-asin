import React from "react"
import {Button, Form, FormLabel} from "react-bootstrap";

class Searchbar extends React.Component {

  constructor(props) {
    super(props);
  }

  render() {
    return (
      <Form onSubmit={this.props.onSubmit}>
        <Form.Control
          size="lg"
          type="text"
          placeholder="Enter an ASIN"
          onChange={this.onChange}
        />
        <br/>
        <Button type="submit">Submit</Button>
      </Form>
    );
  }
}

export default Searchbar
