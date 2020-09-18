using UnityEngine;

public class LaserControl : MonoBehaviour {
    private readonly float _laserDamage = 0.1f;
    private readonly float _laserLengthOff = 0f;
    private readonly float _laserLengthOn = GameManager.CameraBounds.x;
    private Collider _laserCollider;
    private bool _laserIsOn;
    private Vector3 _laserScale;
    private float _laserTimer;
    private Transform _playerTransform;

    private void Awake(){
        _playerTransform = GameObject.FindWithTag("Player").transform;
        transform.position = _playerTransform.position;
        gameObject.SetActive(true);
    }

    private void Update(){
        transform.position = _playerTransform.position;
        if (_laserIsOn) _laserTimer -= Time.deltaTime;
        if (_laserTimer <= 0f) {
            WeaponPool.Instance.ReturnToPool(WeaponType.Laser, gameObject);
            gameObject.SetActive(false);
        }
    }

    private void OnEnable(){
        _laserScale.z = _laserLengthOn;
        gameObject.transform.localScale = _laserScale;
        _laserIsOn = true;
        _laserTimer = 0.2f;
        gameObject.SetActive(true);
    }

    private void OnDisable(){
        _laserScale.z = _laserLengthOff;
        gameObject.transform.localScale = _laserScale;
        _laserIsOn = false;
        WeaponPool.Instance.ReturnToPool(WeaponType.Laser, gameObject);
    }


    private void OnTriggerEnter(Collider other){
        if (!other.gameObject.CompareTag("Enemy")) return;
        other.GetComponent<EnemyController>().TakeDamage(_laserDamage);
    }


    private void OnTriggerExit(Collider other){
        if (!other.gameObject.CompareTag("Enemy")) return;
        other.GetComponent<EnemyController>().TakeDamage(_laserDamage);
    }

    private void OnTriggerStay(Collider other){
        if (!other.gameObject.CompareTag("Enemy")) return;
        other.GetComponent<EnemyController>().TakeDamage(_laserDamage);
    }
}