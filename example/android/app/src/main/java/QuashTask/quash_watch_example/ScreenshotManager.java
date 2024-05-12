import android.graphics.Bitmap;
import android.media.Image;
import android.media.projection.MediaProjection;
import android.media.projection.MediaProjectionManager;
import android.os.Build;
import android.os.Environment;
import android.os.Handler;
import android.util.DisplayMetrics;
import android.view.WindowManager;
import io.flutter.plugin.common.MethodChannel.Result;
import android.media.ImageReader;

import java.io.File;
import java.io.FileOutputStream;
import java.nio.ByteBuffer;

public class ScreenshotManager {
       private MediaProjection mediaProjection;
    private final MediaProjectionManager mediaProjectionManager;
    private final WindowManager windowManager;

    public ScreenshotManager(MediaProjectionManager mediaProjectionManager, WindowManager windowManager) {
        this.mediaProjectionManager = mediaProjectionManager;
        this.windowManager = windowManager;
    }

    public void takeScreenshot(final Result result) {
        if (mediaProjection != null) {
            captureScreenImage(result);
        } else {
            result.error("MEDIA_PROJECTION_NOT_INITIALIZED", "Media projection is not initialized", null);
        }
    }

    public void setMediaProjection(MediaProjection mediaProjection) {
        this.mediaProjection = mediaProjection;
    }

    private void captureScreenImage(final Result result) {
        DisplayMetrics displayMetrics = new DisplayMetrics();
        windowManager.getDefaultDisplay().getMetrics(displayMetrics);
        int width = displayMetrics.widthPixels;
        int height = displayMetrics.heightPixels;

        ImageReader imageReader = null;
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.KITKAT) {
            imageReader = ImageReader.newInstance(width, height, 0x1, 2);
        }

        final ImageReader finalImageReader = imageReader;
        Handler handler = new Handler();
        handler.postDelayed(new Runnable() {
            @Override
            public void run() {
                Image image = finalImageReader.acquireLatestImage();
                Image.Plane[] planes = image.getPlanes();
                ByteBuffer buffer = planes[0].getBuffer();
                int pixelStride = planes[0].getPixelStride();
                int rowStride = planes[0].getRowStride();
                int rowPadding = rowStride - pixelStride * width;
                Bitmap bitmap = Bitmap.createBitmap(width + rowPadding / pixelStride, height, Bitmap.Config.ARGB_8888);
                bitmap.copyPixelsFromBuffer(buffer);
                image.close();

                // Save the bitmap to a file
                String imagePath = saveBitmapToFile(bitmap);

                result.success(imagePath);
            }
        }, 1000);
    }

    private String saveBitmapToFile(Bitmap bitmap) {
        File filePath = Environment.getExternalStoragePublicDirectory(Environment.DIRECTORY_DOWNLOADS);
        String fileName = "screenshot.png";
        File file = new File(filePath, fileName);
        try {
            FileOutputStream fileOutputStream = new FileOutputStream(file);
            bitmap.compress(Bitmap.CompressFormat.PNG, 100, fileOutputStream);
            fileOutputStream.flush();
            fileOutputStream.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return file.getAbsolutePath();
    }
}
