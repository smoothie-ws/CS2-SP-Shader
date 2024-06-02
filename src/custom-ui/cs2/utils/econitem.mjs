import { File } from "./file.mjs";

export class EconItem {
    static importFrom(url) {
        alg.log.warning(`Imported parameters from ${File.getFileName(url)}.econitem`);
        var fileContent = File.readFile(url);
        alg.log.info(fileContent);
    }

    static exportTo(url) {
        alg.log.warning(`Exported parameters to ${File.getFileName(url)}.econitem`)
        var fileContent = File.readFile(url);
        alg.log.info(fileContent);
    }
}