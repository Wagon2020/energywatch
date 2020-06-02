const test1 = "/api?documentType=A65&processType=A01&outBiddingZone_Domain=10YCZ-CEPS-----N&periodStart=201512312300&periodEnd=201612312300"
const token = "/api?securityToken=dfb276c1-986a-4e92-a736-74d584bb782c"


const getDataFromApi = () => {
  // const searchWord = event.currentTarget.value;
  fetch(`https://transparency.entsoe.eu${token}${test1}`)
    .then(response => response.json())
    .then(data => console.log(data));
};


getDataFromApi();

// export { getDataFromApi };

// myInput.addEventListener('keyup', getQueryFromSomewhere);

