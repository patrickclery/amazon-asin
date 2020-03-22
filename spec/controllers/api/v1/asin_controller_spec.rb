RSpec.describe Api::V1::AsinController, type: :controller do

  ############################################################################
  # Setup a basic form with a three inputs
  # Eager load these
  let!(:form) { create(:form, key: "duval", name: "Rhodes, Pratt and Martin") }
  let!(:tag_1) { create(:tag, form: form, name: "Type") }
  let!(:tag_2) { create(:tag, form: form, name: "Subsidiary") }
  let!(:option_1) { create(:option, tag: tag_1, name: "Electricity (kWh)") }
  let!(:option_2) { create(:option, tag: tag_1, name: "Natural gas (GJ)") }
  let!(:option_3) { create(:option, tag: tag_1, name: "Fuel oil (Liter)") }
  let!(:option_4) { create(:option, tag: tag_2, name: "Montreal") }
  let!(:option_5) { create(:option, tag: tag_2, name: "Paris") }
  let!(:option_6) { create(:option, tag: tag_2, name: "Tokyo") }
  let!(:input_1) { create(:input, form: form, choices: [option_1, option_4]) }
  let!(:input_2) { create(:input, form: form, choices: [option_2, option_5]) }
  let!(:input_3) { create(:input, form: form, choices: [option_3, option_6]) }

  ############################################################################
  describe "GET #index" do
    # Don't eager load these
    subject(:request) { get :index, params: { form_id: form._id.to_s } }
    let(:json_data) { JSON.parse(request.body)["data"] }

    it { should be_successful }
    it { expect(subject.media_type).to eq("application/json") }
    it { expect(json_data).to be_an(Array) }
    it { expect(json_data.size).to eq 3 }
  end

  ############################################################################
  # Create just one input in the database and compare it
  describe "GET #show" do
    subject(:request) do
      get :show,
          params: {
            form_id: form._id.to_s,
            id:      input._id.to_s
          }
    end
    let(:json_data) { JSON.parse(request.body)["data"] }
    # Eager load these
    let!(:input) do
      create :input,
             form:  form,
             date:  "1990-10-24",
             note:  "Current change employee end exactly factor sort.",
             value: "1133"
    end

    it { should be_successful }
    it { expect(subject.media_type).to eq("application/json") }
    # Verify all the JSON data
    it { expect(json_data["id"]).to eq Input.find_by(value: "1133")._id.to_s }
    it { expect(json_data["attributes"].keys).to contain_exactly("date", "note", "value", "choices") }
    it { expect(json_data["attributes"]["date"]).to eq "1990-10-24" }
    it { expect(json_data["attributes"]["note"]).to eq "Current change employee end exactly factor sort." }
    it { expect(json_data["attributes"]["value"]).to eq "1133" }
  end

  ############################################################################
  describe "POST #create" do
    # Don't eager load these
    subject(:request) do
      post :create,
           params: { form_id:    form._id.to_s,
                     date:       "2016-10-13",
                     note:       "Et et neque accusantium voluptatum illo. Quas rerum occaecati deserunt aspernatur nam consectetur deleniti. Rerum nulla eum deleniti vitae explicabo.",
                     value:      "7303",
                     choice_ids: [option_1.id, option_2.id, option_3.id] }
    end
    let(:json_data) { JSON.parse(request.body)["data"] }

    it { should be_successful }
    it { expect(subject.media_type).to eq("application/json") }
    it { expect { subject }.to change { Input.count }.by(1) }

    # I realize this is very "hacky" but with MongoDB it doesn't use a join model like "InputOption" (a.k.a. "Choice") so I have to reload the model this way
    it { expect { subject }.to change { option_1.reload.inputs.count }.by(1) }
    it { expect { subject }.to change { option_2.reload.inputs.count }.by(1) }
    it { expect { subject }.to change { option_3.reload.inputs.count }.by(1) }

    it { expect(json_data["attributes"].keys).to contain_exactly("date", "note", "value", "choices") }
    it { expect(json_data["attributes"]["date"]).to eq "2016-10-13" }
    it { expect(json_data["attributes"]["note"]).to eq "Et et neque accusantium voluptatum illo. Quas rerum occaecati deserunt aspernatur nam consectetur deleniti. Rerum nulla eum deleniti vitae explicabo." }
    it { expect(json_data["attributes"]["value"]).to eq "7303" }
  end

end
