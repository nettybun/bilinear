const fs = require('fs');
const files = process.argv.slice(2);
// For CSV
console.log(`file,content.length,instruction,count,percentage`);
files.forEach(work);

function work(file) {
  if (!file) throw 'No file';
  const content = fs.readFileSync(file, 'utf-8').split('\n');
  // For non-CSV
  // console.log(`File "${file}"`)
  // console.log(`${content.length} lines`);

  const count = new Map();
  for (const line of content) {
    if (line[0] !== '\t' || line[1] === '.') {
      // console.log('Skip', line);
      continue;
    }
    const split = line.trim().split(/\s+/);
    const match = split[0];
    const res = (count.get(match) || { name: match, count: 0 });
    res.count++;
    count.set(match, res);
  }

  const arr = Array.from(count.values()).sort((a, b) => b.count - a.count);
  const total = arr.reduce((acc, o) => acc += o.count, 0);
  for (const { name, count } of arr) {
    const percentage = (count / total) * 100;
    // For CSV
    console.log(`${file},${content.length},${name},${count},${percentage.toFixed(2)}%`);

    // For non-CSV
    // if (percentage < 1) break;
    // console.log(`${name.padEnd(15)}${String(count).padEnd(5)} ${percentage.toFixed(2)}%`);

    // For the report (Google Docs merges spaces so need to use periods...)
    // console.log(`${(name + ' ').padEnd(15, '.')} ${(count + ' ').padEnd(5, '.')} ${percentage.toFixed(2)}%`);
  }
  console.log('\n');
}
