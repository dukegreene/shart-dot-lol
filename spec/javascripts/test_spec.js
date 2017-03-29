describe('Shart', function () {
  var shart = new Shart({smell: "awful", size: "enormous"})
    it('has a smell', function () {
        expect(shart.smell).toEqual("awful");
    });
});