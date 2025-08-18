const generateUserId = async () => {

    const letters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
    const numbers = '1234567890';

    const prefix = letters.charAt(Math.floor(Math.random() * letters.length)) + letters.charAt(Math.floor(Math.random() * letters.length));
    const midpix = Array.from({ length: 4 }, () => numbers.charAt(Math.floor(Math.random() * numbers.length))).join('');
    const suffix = letters.charAt(Math.floor(Math.random() * letters.length));

    return prefix + midpix + suffix;

}

export default generateUserId;