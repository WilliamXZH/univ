package tool;

import java.util.Optional;

import javafx.scene.control.Alert;
import javafx.scene.control.ButtonBar;
import javafx.scene.control.ButtonType;

public class AlertBox extends Alert {
	private ButtonType yes=new ButtonType("ȷ��", ButtonBar.ButtonData.YES);
	private ButtonType no = new ButtonType("ȡ��", ButtonBar.ButtonData.NO);
	public AlertBox(String title, String text) {
		super(Alert.AlertType.CONFIRMATION);
		this.setTitle(title);
		this.setContentText(text);
	}

	public boolean isYes() {
		this.getButtonTypes().setAll(yes,no);
		Optional<ButtonType> _buttonType = this.showAndWait();
		if (_buttonType.get().getButtonData().equals(ButtonBar.ButtonData.YES)) {
			return true;
		} else {
			return false;
		}
	}
	public void alert() {
		this.getButtonTypes().setAll(yes);
		this.showAndWait();
	}
	
}
