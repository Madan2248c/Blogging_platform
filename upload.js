document.getElementById('uploadForm').addEventListener('submit', async function (e) {
    e.preventDefault();

    const formData = new FormData();
    const title = document.getElementById('title').value;
    const content = document.getElementById('content').value;
    const image = document.getElementById('image').files[0];

    formData.append('title', title);
    formData.append('content', content);
    formData.append('image', image);

    try {
        const response = await fetch('http://localhost:3000/blog/newblog', {
            method: 'POST',
            body: formData,
        });

        const result = await response.text();
        document.getElementById('responseMessage').innerText = result;
    } catch (error) {
        console.error('Error uploading the image:', error);
        document.getElementById('responseMessage').innerText = 'Failed to upload blog.';
    }
});
