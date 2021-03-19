exports._parseJSON = JSON.parse;

exports._undefined = undefined;

exports.unsafeStringify = function (x) {
    return JSON.stringify(x);
};