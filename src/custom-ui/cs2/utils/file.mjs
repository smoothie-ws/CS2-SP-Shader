export class File {
    static readFile(url) {
        var xhr = new XMLHttpRequest();
        xhr.open("GET", url, false);
        xhr.send();
        
        if (xhr.status !== 200) { 
            throw new Error("Error reading file: ", xhr.status, xhr.statusText);
        }
    
        return xhr.responseText;
    }

    static writeFile(url, content) {
        var xhr = new XMLHttpRequest();
        xhr.open("PUT", url, false);
        xhr.setRequestHeader("Content-Type", "text/plain;charset=UTF-8");
        xhr.send(content);
        
        if (xhr.status !== 201 && xhr.status !== 204) {
            throw new Error("Error writing file: ", xhr.status, xhr.statusText);
        }
    }
    
    static getFileName(url) {
        return url.toString().split("/").pop().split(".")[0];
    }
}
